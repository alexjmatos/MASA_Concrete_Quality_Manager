import '../models/concrete_testing_remission.dart';
import 'filter_criteria.dart';

class CompositeFilter implements FilterCriteria {
  final List<FilterCriteria> criteria;

  CompositeFilter(this.criteria);

  @override
  bool matches(ConcreteTestingRemission element) {
    for (var criterion in criteria) {
      if (!criterion.matches(element)) {
        return false;
      }
    }
    return true;
  }
}
