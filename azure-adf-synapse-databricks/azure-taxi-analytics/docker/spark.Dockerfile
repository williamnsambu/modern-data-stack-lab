FROM bitnami/spark:3.5.1

USER root
RUN install_packages python3 python3-pip && \
    pip3 install --no-cache-dir pyspark==3.5.1 pyarrow==15.0.0 fastparquet==2024.5.0 pandas==2.2.2 delta-spark==3.1.0
USER 1001
