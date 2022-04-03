FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY grpc-server.py /app/

EXPOSE 50051

CMD [ "python", "grpc-server.py" ]