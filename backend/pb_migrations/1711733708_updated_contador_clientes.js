/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "qsx0ya52",
    "name": "cliente_id",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "tzh8rr90bve47xa",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("kq1m01a6gss4ftn")

  // remove
  collection.schema.removeField("qsx0ya52")

  return dao.saveCollection(collection)
})
