from concurrent import futures
import logging

import grpc
from grpc_reflection.v1alpha import reflection
import greeting_pb2
import greeting_pb2_grpc


class Greeter(greeting_pb2_grpc.GreeterServicer):

    def Greeting(self, request, context):
        return greeting_pb2.GreetingReply(message='Hello, from a Python gRPC server with reflection')


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    greeting_pb2_grpc.add_GreeterServicer_to_server(Greeter(), server)
    SERVICE_NAMES = (
        greeting_pb2.DESCRIPTOR.services_by_name['Greeter'].full_name,
        reflection.SERVICE_NAME,
    )
    reflection.enable_server_reflection(SERVICE_NAMES, server)
    server.add_insecure_port('[::]:50051')
    print('Starting gRPC server on port 50051..')
    server.start()
    print('Started gRPC server on port 50051..')
    server.wait_for_termination()


if __name__ == '__main__':
    logging.basicConfig()
    serve()