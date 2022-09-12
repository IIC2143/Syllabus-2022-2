# Dataset Generator

Con tal de facilitar el desarrollo de su tarea, además de subirles un _dataset_ de prueba junto con su solución, hicimos este pequeño _script_ para que puedan generar _datasets_ propios.

## Ejecución

Primero, se deben instalar las gemas necesarias. Para esto, el _script_ funciona con `bundler`:
```bash
bundle install
```

Luego, ejecutar el archivo **main.rb**:
```bash
bundle exec ruby main.rb
```

En el caso de querer cambiar la cantidad de supermercados, clientes, productos y eventos generados, cambiar las variables `SUPERMARKET_QUANTITY`, `CLIENT_QUANTITY`, `PRODUCT_QUANTITY` y `EVENT_QUANTITY`.
