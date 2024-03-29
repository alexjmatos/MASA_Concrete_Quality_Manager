/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  // remove
  collection.schema.removeField("ui3krpo0")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fbzfj8yr",
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
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ui3krpo0",
    "name": "consecutivo",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "2x3b3eqiysghwud",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  // remove
  collection.schema.removeField("fbzfj8yr")

  return dao.saveCollection(collection)
})
