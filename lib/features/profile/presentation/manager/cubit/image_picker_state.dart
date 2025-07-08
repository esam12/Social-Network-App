part of 'image_picker_cubit.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImagePickerState {}

class ImagePicked extends ImagePickerState {
  final File imageFile;
  final DateTime timestamp;

  ImagePicked(this.imageFile) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [imageFile.path, timestamp];
}

class ImagePickerError extends ImagePickerState {
  final String message;

  const ImagePickerError(this.message);

  @override
  List<Object?> get props => [message];
}
