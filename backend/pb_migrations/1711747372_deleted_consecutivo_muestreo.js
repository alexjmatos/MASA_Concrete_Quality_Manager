/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("ry2mslmjxy6sorn");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "ry2mslmjxy6sorn",
    "created": "2024-03-29 17:33:48.988Z",
    "updated": "2024-03-29 17:59:00.609Z",
    "name": "consecutivo_muestreo",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "ypxa9nsd",
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
        "id": "sdqaivca",
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
