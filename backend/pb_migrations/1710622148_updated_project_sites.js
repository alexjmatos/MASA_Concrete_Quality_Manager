/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "pmo9hm3a",
    "name": "assigned_companies",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "tzh8rr90bve47xa",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  // remove
  collection.schema.removeField("pmo9hm3a")

  return dao.saveCollection(collection)
})
