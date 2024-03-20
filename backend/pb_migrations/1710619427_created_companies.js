/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "tzh8rr90bve47xa",
    "created": "2024-03-16 20:03:47.190Z",
    "updated": "2024-03-16 20:03:47.190Z",
    "name": "companies",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "jhwedzns",
        "name": "company_name",
        "type": "text",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "0ba07qm2",
        "name": "manager_id",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "zopeijwbvmiq5a4",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "iydvmwrf",
        "name": "main_location_id",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "4s6q4bwh0jofrbl",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("tzh8rr90bve47xa");

  return dao.deleteCollection(collection);
})
