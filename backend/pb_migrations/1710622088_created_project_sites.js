/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "pt5b8cz4jipz80y",
    "created": "2024-03-16 20:48:08.670Z",
    "updated": "2024-03-16 20:48:08.670Z",
    "name": "project_sites",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "ttaoytxw",
        "name": "site_name",
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
        "id": "ynu6sq2m",
        "name": "location_id",
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
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y");

  return dao.deleteCollection(collection);
})
