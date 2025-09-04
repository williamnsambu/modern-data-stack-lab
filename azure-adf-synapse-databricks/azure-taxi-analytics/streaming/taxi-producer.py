import argparse, json, os, random, sys, time
from datetime import datetime, timedelta
try:
    from azure.eventhub import EventHubProducerClient, EventData
except Exception:
    EventHubProducerClient = None
    EventData = None

ZONES = ["Downtown","Uptown","Midtown","Airport","Suburb"]

def gen_event(i):
    pickup = datetime.utcnow()
    duration = random.randint(3, 45)
    dropoff = pickup + timedelta(minutes=duration)
    return {
        "ride_id": f"R{i:09d}",
        "vendor": random.choice(["CMT","VTS"]),
        "pickup_ts": pickup.isoformat(timespec="seconds")+"Z",
        "dropoff_ts": dropoff.isoformat(timespec="seconds")+"Z",
        "pickup_zone": random.choice(ZONES),
        "dropoff_zone": random.choice(ZONES),
        "passengers": random.randint(1, 4),
        "fare_amount": round(random.uniform(5, 120), 2),
        "tip_amount": round(random.uniform(0, 25), 2)
    }

def write_local(path, event):
    os.makedirs(path, exist_ok=True)
    fname = os.path.join(path, f"event_{int(time.time()*1000)}_{random.randint(0,9999)}.json")
    with open(fname, "w", encoding="utf-8") as f:
        f.write(json.dumps(event) + "\n")

def send_eventhub(conn_str, hub, event):
    if EventHubProducerClient is None:
        raise RuntimeError("azure-eventhub not installed. Use --mode local or pip install azure-eventhub")
    producer = EventHubProducerClient.from_connection_string(conn_str, eventhub_name=hub)
    with producer:
        batch = producer.create_batch()
        batch.add(EventData(json.dumps(event)))
        producer.send_batch(batch)

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("--mode", choices=["local","eventhub"], default="local")
    p.add_argument("--rate", type=int, default=5)
    p.add_argument("--minutes", type=int, default=1)
    p.add_argument("--landing", default="./_local_stream/landing")
    args = p.parse_args()

    total = args.rate * args.minutes * 60
    print(f"Producing ~{total} events to {args.mode}...")

    if args.mode == "eventhub":
        conn = os.getenv("EVENTHUB_CONNECTION_STRING")
        hub = os.getenv("EVENTHUB_NAME", "taxi-stream")
        if not conn:
            print("Missing EVENTHUB_CONNECTION_STRING", file=sys.stderr)
            sys.exit(2)

    i = 0
    try:
        start = time.time()
        while i < total:
            ev = gen_event(i)
            if args.mode == "local":
                write_local(args.landing, ev)
            else:
                send_eventhub(conn, hub, ev)
            i += 1
            # naive rate control
            time.sleep(max(0, (i/args.rate) - (time.time()-start)))
    except KeyboardInterrupt:
        pass
    print("Done.")
