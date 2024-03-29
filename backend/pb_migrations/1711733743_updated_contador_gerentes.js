/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0fxrcsec20en773")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "lvj5gird",
    "name": "gerente_id",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "c8t6d6qgba6slko",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0fxrcsec20en773")

  // remove
  collection.schema.removeField("lvj5gird")

  return dao.saveCollection(collection)
})
