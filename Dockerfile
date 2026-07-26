FROM public.ecr.aws/d3j8x8q7/olympus-base-python:latest

WORKDIR /app

COPY . .

RUN python -m pip install --upgrade pip
RUN python -m pip install -e .
RUN python -m pip install --no-cache-dir \
    "hypothesis==6.116.0" \
    "pyarrow==23.0.0"

CMD ["/bin/bash"]