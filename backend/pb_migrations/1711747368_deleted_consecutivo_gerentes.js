/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("0fxrcsec20en773");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "0fxrcsec20en773",
    "created": "2024-03-29 17:30:50.346Z",
    "updated": "2024-03-29 17:58:54.020Z",
    "name": "consecutivo_gerentes",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "dx0qam3v",
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
        "id": "azpkbbmf",
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
