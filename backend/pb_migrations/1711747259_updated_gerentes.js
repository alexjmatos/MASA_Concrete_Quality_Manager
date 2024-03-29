/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("c8t6d6qgba6slko")

  // remove
  collection.schema.removeField("hlwajnmx")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "i9znmrz9",
    "name": "consecutivo",
    "type": "number",
    "required": true,
    "presentable": true,
    "unique": false,
    "options": {
      "min": 1,
      "max": null,
      "noDecimal": true
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
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

  // remove
  collection.schema.removeField("i9znmrz9")

  return dao.saveCollection(collection)
})
