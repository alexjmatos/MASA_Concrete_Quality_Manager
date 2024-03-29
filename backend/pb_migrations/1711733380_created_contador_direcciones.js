/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "4tsftbf5djxkj6s",
    "created": "2024-03-29 17:29:40.919Z",
    "updated": "2024-03-29 17:29:40.919Z",
    "name": "contador_direcciones",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "uamouoi6",
        "name": "contador",
        "type": "number",
        "required": true,
        "presentable": true,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "noDecimal": true
        }
      },
      {
        "system": false,
        "id": "x0i4p21s",
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
  const collection = dao.findCollectionByNameOrId("4tsftbf5djxkj6s");

  return dao.deleteCollection(collection);
})
