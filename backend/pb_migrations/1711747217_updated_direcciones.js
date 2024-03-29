/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  // remove
  collection.schema.removeField("47nmpghr")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "05sx83sb",
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
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "47nmpghr",
    "name": "consecutivo",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "4tsftbf5djxkj6s",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  // remove
  collection.schema.removeField("05sx83sb")

  return dao.saveCollection(collection)
})
