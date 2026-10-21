import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/portfolio_item_model.dart';
import '../repositories/cv_repository.dart';

class GetPortfolioUseCase implements UseCase<DataState<List<PortfolioItemModel>>, NoParams> {
  GetPortfolioUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<List<PortfolioItemModel>>> call({NoParams? params}) => repository.getPortfolio();
}
