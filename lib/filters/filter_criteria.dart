import 'package:masa_epico_concrete_manager/dto/concrete_sample_dto.dart';

import '../database/app_database.dart';

abstract class FilterCriteria {
  bool matches(ConcreteSampleDTO element);
}

// Concrete implementations for each criterion
class BuildingSiteCriteria implements FilterCriteria {
  final BuildingSite? selectedBuildingSite;

  BuildingSiteCriteria(this.selectedBuildingSite);

  @override
  bool matches(ConcreteSampleDTO element) {
    return selectedBuildingSite == null ||
        element.testingOrder?.buildingSite?.id == selectedBuildingSite?.id;
  }
}

class DesignResistanceCriteria implements FilterCriteria {
  final String? selectedDesignResistance;

  DesignResistanceCriteria(this.selectedDesignResistance);

  @override
  bool matches(ConcreteSampleDTO element) {
    return selectedDesignResistance == null ||
        element.testingOrder?.designResistance == selectedDesignResistance;
  }
}

class DesignAgeCriteria implements FilterCriteria {
  final String? selectedDesignAge;

  DesignAgeCriteria(this.selectedDesignAge);

  @override
  bool matches(ConcreteSampleDTO element) {
    return selectedDesignAge == null ||
        element.testingOrder?.designAge == selectedDesignAge;
  }
}
