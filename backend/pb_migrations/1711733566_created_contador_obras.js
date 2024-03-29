/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "2x3b3eqiysghwud",
    "created": "2024-03-29 17:32:46.567Z",
    "updated": "2024-03-29 17:32:46.567Z",
    "name": "contador_obras",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "lhrohduo",
        "name": "field",
        "type": "number",
        "required": true,
        "presentable": true,
        "unique": false,
        "options": {
          "min": 1,
          "max": null,
          "noDecimal": true
        }
      },
      {
        "system": false,
        "id": "9ogr76op",
        "name": "activo",
        "type": "bool",
        "required": false,
        "presentable": true,
        "unique": false,
        "options": {}
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
  const collection = dao.findCollectionByNameOrId("2x3b3eqiysghwud");

  return dao.deleteCollection(collection);
})
