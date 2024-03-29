/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("c8t6d6qgba6slko")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "hlwajnmx",
    "name": "consecutivo",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "0fxrcsec20en773",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("c8t6d6qgba6slko")

  // remove
  collection.schema.removeField("hlwajnmx")

  return dao.saveCollection(collection)
})
