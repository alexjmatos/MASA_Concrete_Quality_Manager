/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4r04ttoziv5f09u")

  // remove
  collection.schema.removeField("vcsrhc8j")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4r04ttoziv5f09u")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "vcsrhc8j",
    "name": "residente_id",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "zopeijwbvmiq5a4",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
})
