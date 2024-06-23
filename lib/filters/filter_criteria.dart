// Interface for filter criteria
import '../models/building_site.dart';
import '../models/concrete_testing_remission.dart';

abstract class FilterCriteria {
  bool matches(ConcreteTestingRemission element);
}

// Concrete implementations for each criterion
class BuildingSiteCriteria implements FilterCriteria {
  final BuildingSite? selectedBuildingSite;

  BuildingSiteCriteria(this.selectedBuildingSite);

  @override
  bool matches(ConcreteTestingRemission element) {
    return selectedBuildingSite == null ||
        element.concreteTestingOrder.buildingSite.id ==
            selectedBuildingSite?.id;
  }
}

class DesignResistanceCriteria implements FilterCriteria {
  final String? selectedDesignResistance;

  DesignResistanceCriteria(this.selectedDesignResistance);

  @override
  bool matches(ConcreteTestingRemission element) {
    return selectedDesignResistance == null ||
        element.concreteTestingOrder.designResistance ==
            selectedDesignResistance;
  }
}

class DesignAgeCriteria implements FilterCriteria {
  final String? selectedDesignAge;

  DesignAgeCriteria(this.selectedDesignAge);

  @override
  bool matches(ConcreteTestingRemission element) {
    return selectedDesignAge == null ||
        element.concreteTestingOrder.designAge == selectedDesignAge;
  }
}
