/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r6p9bzfjtrs50xk")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "eqxkzpld",
    "name": "consecutivo",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "ry2mslmjxy6sorn",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r6p9bzfjtrs50xk")

  // remove
  collection.schema.removeField("eqxkzpld")

  return dao.saveCollection(collection)
})
