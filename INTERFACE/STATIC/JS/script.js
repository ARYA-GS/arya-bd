// static/js/script.js

document.addEventListener('DOMContentLoaded', () => {
    // --- Seletores de Elementos ---
    const profileSelector = document.getElementById('profile-selector');
    const collectionSelector = document.getElementById('collection-selector');
    const tableHead = document.querySelector('#data-table thead');
    const tableBody = document.querySelector('#data-table tbody');
    const tableMessage = document.getElementById('table-message');
    const addNewBtn = document.getElementById('add-new-btn');
    const exportJsonBtn = document.getElementById('export-json-btn');
    const exportCsvBtn = document.getElementById('export-csv-btn');
    const messageContainer = document.getElementById('message-area');

    // --- Modal e Formulário ---
    const modal = document.getElementById('form-modal');
    const form = document.getElementById('data-form');
    const formTitle = document.getElementById('form-title');
    const formFields = document.getElementById('form-fields');
    const docIdInput = document.getElementById('doc-id');
    const saveBtn = document.getElementById('save-btn');
    const cancelBtn = document.getElementById('cancel-btn');
    const closeModalBtn = document.getElementById('close-modal-btn');

    // --- Variáveis de Estado ---
    let currentCollection = '';
    let currentHeaders = [];
    let currentUserProfile = '';

    // --- Funções de Comunicação com a API ---
    const fetchData = async (url, options = {}) => {
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            if (!response.ok) {
                throw new Error(result.erro || `Erro ${response.status}`);
            }
            return result;
        } catch (error) {
            showMessage(error.message, 'error');
            console.error('API Error:', error);
            throw error;
        }
    };

    const fetchCollections = () => {
        fetchData('/api/collections').then(collections => {
            collectionSelector.innerHTML = '<option value="">Selecione uma coleção</option>';
            collections.forEach(col => {
                const option = document.createElement('option');
                option.value = col;
                option.textContent = col;
                collectionSelector.appendChild(option);
            });
        }).catch(() => {
            showMessage('Não foi possível carregar as coleções.', 'error');
        });
    };

    // --- Funções de Renderização e UI ---
    const showMessage = (message, type = 'success') => {
        const icon = type === 'success' ? 'ri-checkbox-circle-line' : 'ri-error-warning-line';
        const toast = document.createElement('div');
        toast.className = `message-toast ${type}`;
        toast.innerHTML = `<i class="${icon}"></i><span>${message}</span>`;
        messageContainer.appendChild(toast);
        setTimeout(() => toast.remove(), 4000);
    };
    
    const updateButtonStates = () => {
        const profileSelected = !!currentUserProfile;
        const collectionSelected = !!currentCollection;
        collectionSelector.disabled = !profileSelected;
        addNewBtn.disabled = !profileSelected || !collectionSelected;
        exportJsonBtn.disabled = !profileSelected || !collectionSelected;
        exportCsvBtn.disabled = !profileSelected || !collectionSelected;
    };

    const renderTable = (data) => {
        tableHead.innerHTML = '';
        tableBody.innerHTML = '';

        if (data.length === 0) {
            tableMessage.textContent = 'Nenhum registro encontrado nesta coleção.';
            tableMessage.style.display = 'block';
            return;
        }
        tableMessage.style.display = 'none';

        const headers = Object.keys(data[0]);
        currentHeaders = headers;
        const headerRow = document.createElement('tr');
        headers.forEach(header => {
            const th = document.createElement('th');
            th.textContent = header;
            headerRow.appendChild(th);
        });
        const thActions = document.createElement('th');
        thActions.textContent = 'Ações';
        headerRow.appendChild(thActions);
        tableHead.appendChild(headerRow);

        data.forEach(row => {
            const tr = document.createElement('tr');
            headers.forEach(header => {
                const td = document.createElement('td');
                const cellData = String(row[header] || '');
                td.textContent = cellData.length > 50 ? cellData.substring(0, 50) + '...' : cellData;
                td.title = cellData;
                tr.appendChild(td);
            });

            const tdActions = document.createElement('td');
            tdActions.className = 'actions';

            if (currentUserProfile === 'Equipe de Campo/Drone') {
                const editBtn = document.createElement('button');
                editBtn.className = 'btn-icon';
                editBtn.title = 'Editar';
                editBtn.innerHTML = '<i class="ri-pencil-line"></i>';
                editBtn.addEventListener('click', () => openForm(row, 'edit'));

                const deleteBtn = document.createElement('button');
                deleteBtn.className = 'btn-icon';
                deleteBtn.title = 'Excluir';
                deleteBtn.innerHTML = '<i class="ri-delete-bin-line"></i>';
                deleteBtn.addEventListener('click', () => handleDelete(row._id));
                
                tdActions.appendChild(editBtn);
                tdActions.appendChild(deleteBtn);
            } else { // Perfil "Usuário"
                const viewBtn = document.createElement('button');
                viewBtn.className = 'btn-icon';
                viewBtn.title = 'Visualizar';
                viewBtn.innerHTML = '<i class="ri-eye-line"></i>';
                viewBtn.addEventListener('click', () => openForm(row, 'view'));
                tdActions.appendChild(viewBtn);
            }
            
            tr.appendChild(tdActions);
            tableBody.appendChild(tr);
        });
    };
    
    // --- Funções do Formulário (Modal) ---
    const openForm = (doc = null, mode = 'view') => {
        form.reset();
        formFields.innerHTML = '';
        const isNewDoc = !doc;
        
        docIdInput.value = isNewDoc ? '' : doc._id;
        formTitle.textContent = isNewDoc ? `Novo Registro em ${currentCollection}` : 'Detalhes do Registro';
        
        const isEditable = mode === 'edit' || isNewDoc;
        
        saveBtn.style.display = isEditable ? 'inline-flex' : 'none';
        cancelBtn.textContent = isEditable ? 'Cancelar' : 'Fechar';

        currentHeaders.forEach(header => {
            if (header === '_id') return;
            const group = document.createElement('div');
            group.className = 'form-group';
            const label = document.createElement('label');
            label.setAttribute('for', `field-${header}`);
            label.textContent = header;
            
            const inputType = header.toLowerCase().includes('desc') || String(doc?.[header]).length > 100 ? 'textarea' : 'input';
            const input = document.createElement(inputType);
            if (inputType === 'textarea') input.rows = 3;
            
            input.id = `field-${header}`;
            input.name = header;
            input.value = doc ? (doc[header] || '') : '';
            input.readOnly = !isEditable;

            group.appendChild(label);
            group.appendChild(input);
            formFields.appendChild(group);
        });

        modal.classList.remove('hidden');

        if (isNewDoc) {
            // ############### CORREÇÃO APLICADA AQUI ###############
            // Atrasamos a execução para garantir que o DOM esteja pronto
            setTimeout(autoFillFields, 0);
            // ########################################################
        }
    };
    
    const autoFillFields = () => {
        const now = new Date();

        const padTo2Digits = (num) => String(num).padStart(2, '0');

        const formattedDateTime =
            `${now.getFullYear()}-${padTo2Digits(now.getMonth() + 1)}-${padTo2Digits(now.getDate())}` +
            ` ${padTo2Digits(now.getHours())}:${padTo2Digits(now.getMinutes())}:${padTo2Digits(now.getSeconds())}`;

        const dateTimeInput = document.getElementById('field-data');
        if (dateTimeInput) {
            dateTimeInput.value = formattedDateTime;
        }

        const latInput = document.getElementById('field-latitude');
        const lonInput = document.getElementById('field-longitude');
        if (latInput && lonInput && navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                (pos) => {
                    latInput.value = pos.coords.latitude.toFixed(6);
                    lonInput.value = pos.coords.longitude.toFixed(6);
                },
                (err) => console.warn(`AVISO de Geolocalização: ${err.message}`)
            );
        }
    };

    const closeForm = () => modal.classList.add('hidden');

    // --- Funções de Manipulação de Dados (CRUD e Exportação) ---
    const handleFormSubmit = async (event) => {
        event.preventDefault();
        const id = docIdInput.value;
        const formData = new FormData(form);
        const data = Object.fromEntries(formData.entries());

        const url = id ? `/api/data/${currentCollection}/${id}` : `/api/data/${currentCollection}`;
        const method = id ? 'PUT' : 'POST';

        try {
            await fetchData(url, {
                method: method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data),
            });
            showMessage(`Registro ${id ? 'atualizado' : 'criado'} com sucesso!`, 'success');
            closeForm();
            fetchData(`/api/data/${currentCollection}`).then(renderTable);
        } catch (error) {
            // A mensagem de erro já é mostrada pela função fetchData
        }
    };
    
    const handleDelete = (id) => {
        if (!confirm('Tem certeza que deseja excluir este registro? Esta ação é irreversível.')) return;
        
        fetchData(`/api/data/${currentCollection}/${id}`, { method: 'DELETE' })
            .then(() => {
                showMessage('Registro excluído com sucesso!', 'success');
                fetchData(`/api/data/${currentCollection}`).then(renderTable);
            })
            .catch(error => {
                // A mensagem de erro já é mostrada pela função fetchData
            });
    };
    
    const handleExport = (format) => {
        if (!currentCollection) {
            showMessage('Selecione uma coleção primeiro.', 'error');
            return;
        }
        window.location.href = `/api/export/${currentCollection}?format=${format}`;
    };

    // --- Event Listeners ---
    profileSelector.addEventListener('change', (e) => {
        currentUserProfile = e.target.value;
        collectionSelector.value = '';
        currentCollection = '';
        tableHead.innerHTML = '';
        tableBody.innerHTML = '';
        tableMessage.textContent = currentUserProfile ? 'Por favor, selecione uma coleção.' : 'Por favor, selecione seu perfil para começar.';
        tableMessage.style.display = 'block';
        updateButtonStates();
        if (currentUserProfile) fetchCollections();
    });

    collectionSelector.addEventListener('change', (e) => {
        currentCollection = e.target.value;
        updateButtonStates();
        if (currentCollection) {
            tableMessage.textContent = 'Carregando dados...';
            fetchData(`/api/data/${currentCollection}`).then(renderTable);
        } else {
            tableHead.innerHTML = '';
            tableBody.innerHTML = '';
            tableMessage.textContent = 'Selecione uma coleção para ver os dados.';
        }
    });

    addNewBtn.addEventListener('click', () => openForm(null, 'new'));
    form.addEventListener('submit', handleFormSubmit);
    cancelBtn.addEventListener('click', closeForm);
    closeModalBtn.addEventListener('click', closeForm);
    exportJsonBtn.addEventListener('click', () => handleExport('json'));
    exportCsvBtn.addEventListener('click', () => handleExport('csv'));

    // --- Inicialização ---
    updateButtonStates();
});