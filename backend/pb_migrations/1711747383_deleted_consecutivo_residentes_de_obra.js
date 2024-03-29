/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("4r04ttoziv5f09u");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "4r04ttoziv5f09u",
    "created": "2024-03-29 17:33:16.760Z",
    "updated": "2024-03-29 18:00:25.662Z",
    "name": "consecutivo_residentes_de_obra",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "onqstzu4",
        "name": "contador",
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
        "id": "tfo2aphc",
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
})
