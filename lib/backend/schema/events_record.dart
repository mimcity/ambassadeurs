import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'events_record.g.dart';

abstract class EventsRecord
    implements Built<EventsRecord, EventsRecordBuilder> {
  static Serializer<EventsRecord> get serializer => _$eventsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'Adress')
  String get adress;

  @nullable
  @BuiltValueField(wireName: 'Duration')
  int get duration;

  @nullable
  @BuiltValueField(wireName: 'End')
  DateTime get end;

  @nullable
  @BuiltValueField(wireName: 'Start')
  DateTime get start;

  @nullable
  @BuiltValueField(wireName: 'Place')
  String get place;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EventsRecordBuilder builder) => builder
    ..adress = ''
    ..duration = 0
    ..place = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  EventsRecord._();
  factory EventsRecord([void Function(EventsRecordBuilder) updates]) =
      _$EventsRecord;

  static EventsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createEventsRecordData({
  String adress,
  int duration,
  DateTime end,
  DateTime start,
  String place,
}) =>
    serializers.toFirestore(
        EventsRecord.serializer,
        EventsRecord((e) => e
          ..adress = adress
          ..duration = duration
          ..end = end
          ..start = start
          ..place = place));
