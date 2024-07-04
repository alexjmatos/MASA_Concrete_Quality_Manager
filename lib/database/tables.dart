import 'package:drift/drift.dart';

// Customer table
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get identifier => text().withLength(min: 1, max: 255)();
  TextColumn get companyName => text().withDefault(const Constant("")).withLength(min: 1, max: 255)();
}

// Site Residents table
class SiteResidents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withLength(min: 1, max: 255)();
  TextColumn get lastName => text().withLength(min: 1, max: 255)();
  TextColumn get jobPosition => text().withDefault(const Constant("")).withLength(min: 1, max: 255)();
}

// Building Sites table
class BuildingSites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get siteName => text().withLength(min: 1, max: 255)();
  IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get siteResidentId => integer().nullable().references(SiteResidents, #id)();
}

// Concrete Volumetric Weight table
class ConcreteVolumetricWeights extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get tareWeightGr => real()();
  RealColumn get materialTareWeightGr => real()();
  RealColumn get materialWeightGr => real()();
  RealColumn get tareVolumeCm3 => real()();
  RealColumn get volumetricWeightGrCm3 => real()();
  RealColumn get volumeLoadM3 => real()();
  RealColumn get cementQuantityKg => real()();
  RealColumn get coarseAggregateKg => real()();
  RealColumn get fineAggregateKg => real()();
  RealColumn get waterKg => real()();
  TextColumn get additives => text().nullable()();
  RealColumn get totalLoadKg => real()();
  RealColumn get totalLoadVolumetricWeightRelation => real()();
  RealColumn get percentage => real()();
}

// Concrete Testing Orders table
class ConcreteTestingOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get designResistance => text().withLength(min: 1, max: 255)();
  IntColumn get slumpingCm => integer()();
  IntColumn get totalVolumeM3 => integer()();
  IntColumn get tmaMm => integer()();
  TextColumn get designAge => text().withLength(min: 1, max: 255)();
  DateTimeColumn get testingDate => dateTime()();
  IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get buildingSiteId => integer().references(BuildingSites, #id)();
  IntColumn get siteResidentId => integer().nullable().references(SiteResidents, #id)();
}

// Concrete Samples table
class ConcreteSamples extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get remission => text().withLength(min: 1, max: 255)();
  RealColumn get volume => real()();
  TextColumn get plantTime => text().withLength(min: 1, max: 255)();
  TextColumn get buildingSiteTime => text().withLength(min: 1, max: 255)();
  RealColumn get realSlumpingCm => real()();
  RealColumn get temperatureCelsius => real()();
  TextColumn get location => text().withLength(min: 1, max: 255)();
  IntColumn get concreteTestingOrderId => integer().references(ConcreteTestingOrders, #id)();
  IntColumn get concreteVolumetricWeightId => integer().nullable().references(ConcreteVolumetricWeights, #id)();
}

// Concrete Cylinders table
class ConcreteCylinders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get buildingSiteSampleNumber => integer()();
  IntColumn get testingAgeDays => integer()();
  IntColumn get testingDate => integer()();
  RealColumn get totalLoadKg => real().nullable()();
  RealColumn get diameterCm => real().nullable()();
  RealColumn get resistanceKgfCm2 => real().nullable()();
  RealColumn get median => real().nullable()();
  RealColumn get percentage => real().nullable()();
  IntColumn get concreteSampleId => integer().references(ConcreteSamples, #id)();
}
