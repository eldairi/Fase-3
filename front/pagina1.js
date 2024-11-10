document.addEventListener('DOMContentLoaded', async () => {
  // Cargar datos para el formulario de manera paralela
  await Promise.all([
    cargarClientes(),
    cargarModulos(),
    cargarSeveridades()
  ]);

  // Agregar el evento para crear el ticket
  document.getElementById('crear-ticket-form').addEventListener('submit', async (e) => {
    e.preventDefault(); // Prevenir el comportamiento por defecto del formulario (recarga de página)

    // Obtener los valores de los campos del formulario
    const cliente = document.getElementById('cliente').value;
    const modulo = document.getElementById('modulo').value;
    const severidad = document.getElementById('severidad').value;
    const descBreve = document.getElementById('descripcion-breve').value;
    const descDetallada = document.getElementById('descripcion-detallada').value;

    // Validar los campos antes de enviar el formulario
    const campos = [cliente, modulo, severidad, descBreve, descDetallada];
    if (campos.some(campo => !campo)) {
      alert("Todos los campos son obligatorios.");
      return; // Detener la ejecución si algún campo está vacío
    }

    // Cambiar la estructura de los datos según lo que espera el backend
    const datosTicket = {
      cliente, // ID del cliente
      descripcionBreve: descBreve,
      descripcionDetallada: descDetallada,
      modulo, // ID del módulo
      severidad, // ID de severidad
    };

    // Mostrar imagen de carga mientras procesamos la solicitud
    mostrarImagenDeCarga(true);

    try {
      // Verificar si el ticket ya existe
      const checkResponse = await fetch('http://localhost:3000/api/tickets/check', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(datosTicket),
      });

      if (checkResponse.ok) {
        const checkData = await checkResponse.json();
        if (checkData.exists) {
          alert("Este ticket ya ha sido creado anteriormente.");
          mostrarImagenDeCarga(false);
          return;
        }
      } else {
        throw new Error('Error al verificar si el ticket ya existe.');
      }

      // Enviar la solicitud POST para crear el ticket y la transacción
      const response = await fetch('http://localhost:3000/api/tickets', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(datosTicket),
      });

      const newTicket = await response.json();
      console.log('Nuevo ticket creado:', newTicket);

      // Limpiar el formulario después de crear el ticket
      document.getElementById('crear-ticket-form').reset();

      // Mostrar mensaje de éxito
      alert("Ticket y transacción creados exitosamente");

      // Mostrar el número del ticket y detalles adicionales
      const contenedor = document.getElementById('resultado');
      contenedor.innerHTML = `
        <p>¡Ticket creado exitosamente! Número de ticket: ${newTicket.ticketId}</p>
        <p><strong>Cliente:</strong> ${newTicket.cliente}</p>
        <p><strong>Módulo:</strong> ${newTicket.modulo}</p>
        <p><strong>Severidad:</strong> ${newTicket.severidad}</p>
      `;

    } catch (error) {
      console.error("Error al enviar los datos:", error.message || error);
    } finally {
      // Ocultar la imagen de carga
      mostrarImagenDeCarga(false);
    }
  });

  // Función para mostrar u ocultar la imagen de carga
  function mostrarImagenDeCarga(mostrar) {
    const contenedor = document.getElementById('resultado');
    if (mostrar) {
      contenedor.innerHTML = `
        <img src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWg2cWN2OWFybnY5dHJlaDd3eWJkdW0zbmxieWZjeHBuNmk5MnNqdCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xUPGcml9WG8YmFhIgE/giphy.webp" alt="Cargando..." class="img-fluid mb-4" style="max-width: 150px;">
      `;
    } else {
      contenedor.innerHTML = ''; // Limpiar el contenedor cuando no se está mostrando la carga
    }
  }

  // Función para cargar clientes desde el backend
  async function cargarClientes() {
    try {
      const res = await fetch('http://localhost:3000/api/clientes');
      const clientes = await res.json();
      if (Array.isArray(clientes)) {
        const select = document.getElementById('cliente');
        clientes.forEach(cliente => {
          const option = document.createElement('option');
          option.value = cliente.ID_CLIENTE;
          option.textContent = cliente.NOM_CLIENTE;
          select.appendChild(option);
        });
      } else {
        throw new Error('La respuesta de clientes no es un array');
      }
    } catch (error) {
      console.error('Error al cargar clientes:', error);
      mostrarError('Hubo un problema al cargar los clientes. Intenta nuevamente.');
    }
  }

  // Función para cargar módulos desde el backend
  async function cargarModulos() {
    try {
      const res = await fetch('http://localhost:3000/api/modulos');
      const modulos = await res.json();
      if (Array.isArray(modulos)) {
        const select = document.getElementById('modulo');
        modulos.forEach(modulo => {
          const option = document.createElement('option');
          option.value = modulo.ID_MODULO;
          option.textContent = modulo.NOM_MODULO;
          select.appendChild(option);
        });
      } else {
        throw new Error('La respuesta de módulos no es un array');
      }
    } catch (error) {
      console.error('Error al cargar módulos:', error);
      mostrarError('Hubo un problema al cargar los módulos. Intenta nuevamente.');
    }
  }

  // Función para cargar severidades desde el backend
  async function cargarSeveridades() {
    try {
      const res = await fetch('http://localhost:3000/api/severidades');
      const severidades = await res.json();
      if (Array.isArray(severidades)) {
        const select = document.getElementById('severidad');
        severidades.forEach(severidad => {
          const option = document.createElement('option');
          option.value = severidad.ID_SEVERIDAD;
          option.textContent = severidad.NOM_SEVERIDAD;
          select.appendChild(option);
        });
      } else {
        throw new Error('La respuesta de severidades no es un array');
      }
    } catch (error) {
      console.error('Error al cargar severidades:', error);
      mostrarError('Hubo un problema al cargar las severidades. Intenta nuevamente.');
    }
  }

  // Función para mostrar mensajes de error
  function mostrarError(mensaje, detalle = '') {
    const contenedor = document.getElementById('resultado');
    contenedor.innerHTML = `
      <img src="https://www.icegif.com/wp-content/uploads/2023/11/icegif-273.gif" alt="Error" class="img-fluid mb-4" style="max-width: 100px;">
      <p>${mensaje}</p>
      ${detalle ? `<p>Detalle: ${detalle}</p>` : ''}
    `;
  }
});
