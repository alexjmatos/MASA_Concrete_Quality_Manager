import '../models/concrete_sample.dart';
import 'filter_criteria.dart';

class CompositeFilter implements FilterCriteria {
  final List<FilterCriteria> criteria;

  CompositeFilter(this.criteria);

  @override
  bool matches(ConcreteSample element) {
    for (var criterion in criteria) {
      if (!criterion.matches(element)) {
        return false;
      }
    }
    return true;
  }
}
