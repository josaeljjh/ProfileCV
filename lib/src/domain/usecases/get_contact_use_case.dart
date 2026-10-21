import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/contact_model.dart';
import '../repositories/cv_repository.dart';

class GetContactUseCase implements UseCase<DataState<ContactModel>, NoParams> {
  GetContactUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<ContactModel>> call({NoParams? params}) => repository.getContact();
}
