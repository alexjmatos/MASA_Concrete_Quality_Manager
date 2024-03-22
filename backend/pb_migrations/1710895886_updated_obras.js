/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pt5b8cz4jipz80y")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ocour6s4",
    "name": "assigned_site_residents",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "zopeijwbvmiq5a4",
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
  collection.schema.removeField("ocour6s4")

  return dao.saveCollection(collection)
})
