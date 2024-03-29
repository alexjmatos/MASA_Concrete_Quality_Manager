/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  // remove
  collection.schema.removeField("47nmpghr")

  return dao.saveCollection(collection)
})
