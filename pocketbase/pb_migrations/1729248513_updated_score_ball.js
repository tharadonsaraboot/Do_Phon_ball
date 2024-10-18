/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("guikev4sd7zsdyl")

  // remove
  collection.schema.removeField("ahcxbby3")

  // remove
  collection.schema.removeField("tmswwhdf")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ee8oow8s",
    "name": "score1",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ebawrrvz",
    "name": "score2",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("guikev4sd7zsdyl")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ahcxbby3",
    "name": "score1",
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

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "tmswwhdf",
    "name": "score2",
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

  // remove
  collection.schema.removeField("ee8oow8s")

  // remove
  collection.schema.removeField("ebawrrvz")

  return dao.saveCollection(collection)
})
