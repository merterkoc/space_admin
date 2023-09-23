import 'package:equatable/equatable.dart';

class AstronomicEventModel extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final List<String>? image;
  final Coordinate? coordinate;
  final String? startDate;
  final String? endDate;

  const AstronomicEventModel({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.coordinate,
    this.startDate,
    this.endDate,
  });

  factory AstronomicEventModel.fromJson(Map<String, dynamic> json) {
    return AstronomicEventModel(
      id: json.containsKey('_id') ? json['_id'] ?? '' : '',
      name: json.containsKey('name') ? json['name'] ?? '' : '',
      description:
          json.containsKey('description') ? json['description'] ?? '' : '',
      image: json.containsKey('image')
          ? json['image'] != null
              ? List<String>.from(json['image'])
              : []
          : [],
      coordinate: json.containsKey('coordinate')
          ? Coordinate.fromJson(json['coordinate'])
          : null,
      startDate: json.containsKey('start_date') ? json['start_date'] ?? '' : '',
      endDate: json.containsKey('end_date') ? json['end_date'] ?? '' : '',
    );
  }

  AstronomicEventModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? image,
    String? date,
    Coordinate? coordinate,
    String? startDate,
    String? endDate,
  }) {
    return AstronomicEventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      coordinate: coordinate ?? this.coordinate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'image': image,
      'coordinate': coordinate?.toJson(),
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  @override
  List<Object?> get props =>
      [name, description, image, coordinate, startDate, endDate];
}

class Coordinate extends Equatable {
  final double? latitude;
  final double? longitude;

  const Coordinate({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      latitude: json.containsKey('latitude') ? json['latitude'] ?? 0.0 : null,
      longitude:
          json.containsKey('longitude') ? json['longitude'] ?? 0.0 : null,
    );
  }

  Coordinate copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Coordinate(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
