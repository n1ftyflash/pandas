FROM public.ecr.aws/d3j8x8q7/olympus-base-python:latest

WORKDIR /app
COPY . .

# 1. Install system build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential python3-dev ninja-build pkg-config \
        libblas-dev liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Upgrade pip and install Python build/runtime deps
RUN python -m pip install --upgrade pip
RUN python -m pip install numpy python-dateutil  # runtime libraries
RUN python -m pip install meson meson-python Cython  # build tools

# 3. Build & install pandas (non-editable)
RUN python -m pip install --no-cache-dir .

# 4. Install optional extras (testing/parallel libs)
RUN python -m pip install --no-cache-dir \
        "hypothesis>=6.116.0" \
        "pyarrow>=13.0.0,<14"

CMD ["/bin/bash"]
