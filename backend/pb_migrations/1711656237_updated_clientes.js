/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("tzh8rr90bve47xa")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "83luogfs",
    "name": "obras",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "pt5b8cz4jipz80y",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("tzh8rr90bve47xa")

  // remove
  collection.schema.removeField("83luogfs")

  return dao.saveCollection(collection)
})
