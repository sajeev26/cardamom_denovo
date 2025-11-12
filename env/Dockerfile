# -----------------------------------------------------------
# Base image: Ubuntu 22.04 for compatibility and stability
# -----------------------------------------------------------
FROM ubuntu:22.04

LABEL maintainer="Your Name <youremail@example.com>" \
      description="De novo transcriptome + lncRNA discovery pipeline (Trinity, Salmon, CD-HIT, CPC2, PLEK, FEELnc, Snakemake)"

# -----------------------------------------------------------
# Avoid interactive prompts and set locale
# -----------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# -----------------------------------------------------------
# Install basic dependencies and system libraries
# -----------------------------------------------------------
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-setuptools python3-dev \
    wget curl git unzip gzip tar build-essential cmake \
    sra-tools fastqc fastp \
    libxml2-dev libz-dev libcurl4-openssl-dev libncurses5-dev zlib1g-dev \
    openjdk-11-jre-headless \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------
# Install Snakemake and Python requirements
# -----------------------------------------------------------
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# -----------------------------------------------------------
# Install major RNA-seq tools (Trinity, Salmon, CD-HIT, BUSCO, TransRate)
# -----------------------------------------------------------

# Install Trinity
RUN wget https://github.com/trinityrnaseq/trinityrnaseq/releases/download/Trinity-v2.15.1/Trinity-v2.15.1.FULL.tar.gz && \
    tar -xzf Trinity-v2.15.1.FULL.tar.gz && \
    mv Trinity-v2.15.1 /opt/Trinity && \
    ln -s /opt/Trinity/Trinity /usr/local/bin/Trinity && \
    rm Trinity-v2.15.1.FULL.tar.gz

# Install Salmon
RUN wget https://github.com/COMBINE-lab/salmon/releases/download/v1.10.3/salmon-1.10.3_linux_x86_64.tar.gz && \
    tar -xzf salmon-1.10.3_linux_x86_64.tar.gz && \
    mv salmon-1.10.3_linux_x86_64 /opt/salmon && \
    ln -s /opt/salmon/bin/salmon /usr/local/bin/salmon && \
    rm salmon-1.10.3_linux_x86_64.tar.gz

# Install CD-HIT
RUN apt-get update && apt-get install -y cd-hit && apt-get clean

# Install BUSCO (with dependencies)
RUN pip install busco==5.6.1

# Install TransRate
RUN wget https://github.com/blahah/transrate/releases/download/v1.0.3/transrate-1.0.3-linux-x86_64.tar.gz && \
    tar -xzf transrate-1.0.3-linux-x86_64.tar.gz && \
    mv transrate-1.0.3-linux-x86_64 /opt/transrate && \
    ln -s /opt/transrate/transrate /usr/local/bin/transrate && \
    rm transrate-1.0.3-linux-x86_64.tar.gz

# -----------------------------------------------------------
# Install CPC2, PLEK, FEELnc (for lncRNA prediction)
# -----------------------------------------------------------
RUN git clone https://github.com/biocoder/CPC2_standalone.git /opt/CPC2_standalone && \
    chmod +x /opt/CPC2_standalone/bin/CPC2.py && \
    git clone https://github.com/weilei2014/PLEK.git /opt/PLEK && \
    git clone https://github.com/tderrien/FEELnc.git /opt/FEELnc && \
    cd /opt/FEELnc && make

# Add them to PATH
ENV PATH="/opt/CPC2_standalone/bin:/opt/PLEK:/opt/FEELnc:/opt/Trinity:/opt/salmon/bin:/opt/transrate:$PATH"

# -----------------------------------------------------------
# Set working directory and default command
# -----------------------------------------------------------
WORKDIR /workspace
CMD ["snakemake", "--version"]
