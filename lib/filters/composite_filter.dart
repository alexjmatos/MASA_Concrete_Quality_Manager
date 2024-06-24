import '../models/concrete_testing_sample.dart';
import 'filter_criteria.dart';

class CompositeFilter implements FilterCriteria {
  final List<FilterCriteria> criteria;

  CompositeFilter(this.criteria);

  @override
  bool matches(ConcreteTestingSample element) {
    for (var criterion in criteria) {
      if (!criterion.matches(element)) {
        return false;
      }
    }
    return true;
  }
}
