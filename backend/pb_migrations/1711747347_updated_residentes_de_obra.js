/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zopeijwbvmiq5a4")

  // remove
  collection.schema.removeField("wxycawwj")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "b9fq2lew",
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
  const collection = dao.findCollectionByNameOrId("zopeijwbvmiq5a4")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "wxycawwj",
    "name": "consecutivo",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "4r04ttoziv5f09u",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  // remove
  collection.schema.removeField("b9fq2lew")

  return dao.saveCollection(collection)
})
