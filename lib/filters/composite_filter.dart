import 'package:masa_epico_concrete_manager/dto/concrete_sample_dto.dart';

import 'filter_criteria.dart';

class CompositeFilter implements FilterCriteria {
  final List<FilterCriteria> criteria;

  CompositeFilter(this.criteria);

  @override
  bool matches(ConcreteSampleDTO element) {
    for (var criterion in criteria) {
      if (!criterion.matches(element)) {
        return false;
      }
    }
    return true;
  }
}
