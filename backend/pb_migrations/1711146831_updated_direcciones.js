/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "tozysrxu",
    "name": "colonia",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "a7e40mdq",
    "name": "municipio",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4s6q4bwh0jofrbl")

  // remove
  collection.schema.removeField("tozysrxu")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "a7e40mdq",
    "name": "ciudad",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
})
