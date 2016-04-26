# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: explainer.proto

import sys
_b=sys.version_info[0]<3 and (lambda x:x) or (lambda x:x.encode('latin1'))
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
from google.protobuf import descriptor_pb2
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='explainer.proto',
  package='explainer',
  syntax='proto3',
  serialized_pb=_b('\n\x0f\x65xplainer.proto\x12\texplainer\"#\n\x10\x45xplainerRequest\x12\x0f\n\x07problem\x18\x01 \x01(\t\"%\n\x0e\x45xplainerReply\x12\x13\n\x0b\x65xplanation\x18\x01 \x01(\t2N\n\x05ShiFu\x12\x45\n\tTellMeWhy\x12\x1b.explainer.ExplainerRequest\x1a\x19.explainer.ExplainerReply\"\x00\x42\x33\n\x19\x63om.tardate.lck.explainerB\x0e\x45xplainerProtoP\x01\xa2\x02\x03\x45XPb\x06proto3')
)
_sym_db.RegisterFileDescriptor(DESCRIPTOR)




_EXPLAINERREQUEST = _descriptor.Descriptor(
  name='ExplainerRequest',
  full_name='explainer.ExplainerRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='problem', full_name='explainer.ExplainerRequest.problem', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=30,
  serialized_end=65,
)


_EXPLAINERREPLY = _descriptor.Descriptor(
  name='ExplainerReply',
  full_name='explainer.ExplainerReply',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='explanation', full_name='explainer.ExplainerReply.explanation', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=67,
  serialized_end=104,
)

DESCRIPTOR.message_types_by_name['ExplainerRequest'] = _EXPLAINERREQUEST
DESCRIPTOR.message_types_by_name['ExplainerReply'] = _EXPLAINERREPLY

ExplainerRequest = _reflection.GeneratedProtocolMessageType('ExplainerRequest', (_message.Message,), dict(
  DESCRIPTOR = _EXPLAINERREQUEST,
  __module__ = 'explainer_pb2'
  # @@protoc_insertion_point(class_scope:explainer.ExplainerRequest)
  ))
_sym_db.RegisterMessage(ExplainerRequest)

ExplainerReply = _reflection.GeneratedProtocolMessageType('ExplainerReply', (_message.Message,), dict(
  DESCRIPTOR = _EXPLAINERREPLY,
  __module__ = 'explainer_pb2'
  # @@protoc_insertion_point(class_scope:explainer.ExplainerReply)
  ))
_sym_db.RegisterMessage(ExplainerReply)


DESCRIPTOR.has_options = True
DESCRIPTOR._options = _descriptor._ParseOptions(descriptor_pb2.FileOptions(), _b('\n\031com.tardate.lck.explainerB\016ExplainerProtoP\001\242\002\003EXP'))
import abc
from grpc.beta import implementations as beta_implementations
from grpc.framework.common import cardinality
from grpc.framework.interfaces.face import utilities as face_utilities

class BetaShiFuServicer(object):
  """<fill me in later!>"""
  __metaclass__ = abc.ABCMeta
  @abc.abstractmethod
  def TellMeWhy(self, request, context):
    raise NotImplementedError()

class BetaShiFuStub(object):
  """The interface to which stubs will conform."""
  __metaclass__ = abc.ABCMeta
  @abc.abstractmethod
  def TellMeWhy(self, request, timeout):
    raise NotImplementedError()
  TellMeWhy.future = None

def beta_create_ShiFu_server(servicer, pool=None, pool_size=None, default_timeout=None, maximum_timeout=None):
  import explainer_pb2
  import explainer_pb2
  request_deserializers = {
    ('explainer.ShiFu', 'TellMeWhy'): explainer_pb2.ExplainerRequest.FromString,
  }
  response_serializers = {
    ('explainer.ShiFu', 'TellMeWhy'): explainer_pb2.ExplainerReply.SerializeToString,
  }
  method_implementations = {
    ('explainer.ShiFu', 'TellMeWhy'): face_utilities.unary_unary_inline(servicer.TellMeWhy),
  }
  server_options = beta_implementations.server_options(request_deserializers=request_deserializers, response_serializers=response_serializers, thread_pool=pool, thread_pool_size=pool_size, default_timeout=default_timeout, maximum_timeout=maximum_timeout)
  return beta_implementations.server(method_implementations, options=server_options)

def beta_create_ShiFu_stub(channel, host=None, metadata_transformer=None, pool=None, pool_size=None):
  import explainer_pb2
  import explainer_pb2
  request_serializers = {
    ('explainer.ShiFu', 'TellMeWhy'): explainer_pb2.ExplainerRequest.SerializeToString,
  }
  response_deserializers = {
    ('explainer.ShiFu', 'TellMeWhy'): explainer_pb2.ExplainerReply.FromString,
  }
  cardinalities = {
    'TellMeWhy': cardinality.Cardinality.UNARY_UNARY,
  }
  stub_options = beta_implementations.stub_options(host=host, metadata_transformer=metadata_transformer, request_serializers=request_serializers, response_deserializers=response_deserializers, thread_pool=pool, thread_pool_size=pool_size)
  return beta_implementations.dynamic_stub(channel, 'explainer.ShiFu', cardinalities, options=stub_options)
# @@protoc_insertion_point(module_scope)
