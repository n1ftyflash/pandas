FROM public.ecr.aws/d3j8x8q7/olympus-base-python:latest

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip

# Let pip install all build dependencies from pyproject.toml
RUN python -m pip install .

RUN python -m pip install \
    "hypothesis==6.116.0" \
    "pyarrow==23.0.0"

CMD ["/bin/bash"]