/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ry2mslmjxy6sorn")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ec4ajc8p",
    "name": "muestreo_id",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "r6p9bzfjtrs50xk",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ry2mslmjxy6sorn")

  // remove
  collection.schema.removeField("ec4ajc8p")

  return dao.saveCollection(collection)
})
