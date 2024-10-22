# Restaurants API

## Setup

To build the docker image and create the application container, run:

```bash
docker build .
docker-compose up
```

Open a new terminal window to create the database and run the migrations:

```bash
docker-compose run web rails db:create
docker-compose run web rails db:migrate
```

Connect to ``localhost:3000`` in the browser to see the application running

To run unit tests:

```bash
docker-compose run web bundle exec rspec spec
```

## Live test example

Request

```bash
curl --location 'http://localhost:3000/import' \
--form 'file=@"/path/to/file/restaurant_data.json"'
```

Response

```bash
{
    "result": [
        {
            "menu_item": "Burger",
            "menu": "lunch",
            "restaurant": "Poppo's Cafe",
            "success": true,
            "errors": []
        },
        {
            "menu_item": "Small Salad",
            "menu": "lunch",
            "restaurant": "Poppo's Cafe",
            "success": true,
            "errors": []
        },
        {
            "menu_item": "Burger",
            "menu": "dinner",
            "restaurant": "Poppo's Cafe",
            "success": true,
            "errors": []
        },
        {
            "menu_item": "Large Salad",
            "menu": "dinner",
            "restaurant": "Poppo's Cafe",
            "success": true,
            "errors": []
        },
        {
            "menu_item": "Chicken Wings",
            "menu": "lunch",
            "restaurant": "Casa del Poppo",
            "success": true,
            "errors": []
        },
        {
            "menu_item": "Burger",
            "menu": "lunch",
            "restaurant": "Casa del Poppo",
            "success": true,
            "errors": []
        },
        {
            "menu_item": "Chicken Wings",
            "menu": "lunch",
            "restaurant": "Casa del Poppo",
            "success": false,
            "errors": [
                "Item has already been taken"
            ]
        },
        {
            "menu_item": "Mega \"Burger\"",
            "menu": "dinner",
            "restaurant": "Casa del Poppo",
            "success": true,
            "errors": []
        },
        {
            "menu_item": "Lobster Mac & Cheese",
            "menu": "dinner",
            "restaurant": "Casa del Poppo",
            "success": true,
            "errors": []
        }
    ]
}
```

## Development steps

1. Model the database with all necessary relationships between the tables
2. Create a ``model`` for each entity, add validations and write unit tests to them
3. Create and write unit tests to ``RestaurantsController`` and ``MenusController``
4. Create and write unit tests to ``ImportController`` as well as its service, responsible for processing the JSON data, ``RestaurantDataProcessor``
5. Dockerize the application
6. Test the application with cURL and the file ``restaurant_data.json``

### Assumptions made along the way

1. Restaurant's ``name`` must be unique. If a ``restaurant`` already exists in the database, we handle the processing as an update, since updates may be desirable.
2. Menu's ``name`` must be unique within a ``restaurant`` for the same reason.
3. If a new ``item`` comes in, it gets created. Otherwise, we use the ``item`` already persisted in the database to handle the ``menu_item``.
4. Duplicated ``menu_item`` names within the same ``menu`` aren't allowed so an error is returned for every duplicate.
5. The entire payload is processed inside a transaction. If something goes wrong in the middle of it, the previous modifications get erased. This occurs when a resource's ``name`` is ``null``, for example. In this case, an exception is raised and status 404 with error is returned.
