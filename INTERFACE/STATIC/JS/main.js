document.addEventListener('DOMContentLoaded', () => {
    // Referências aos Elementos da UI
    const collectionList = document.getElementById('collection-list');
    const currentCollectionTitle = document.getElementById('current-collection-title');
    const addNewBtn = document.getElementById('add-new-btn');
    const exportBtn = document.getElementById('export-btn');
    const table = document.querySelector('.table');
    const tableHead = table.querySelector('thead');
    const tableBody = table.querySelector('tbody');
    const initialMessage = document.getElementById('initial-message');
    const loadingSpinner = document.getElementById('loading-spinner');
    const modalContainer = document.getElementById('modal-container');
    const actionPanel = document.getElementById('action-panel');
    const searchInput = document.getElementById('search-input');

    let currentCollection = '';
    let currentData = [];
    let headers = [];
    // --- NOVAS VARIÁVEIS GLOBAIS PARA DADOS DO USUÁRIO ---
    let currentUserLat = null;
    let currentUserLon = null;

    // Mapeamento de nomes de campos, conforme solicitado
    const fieldTranslations = {
        'id_zona': 'ID da Zona', 'regiao': 'Região', 'latitude': 'Latitude', 'longitude': 'Longitude',
        'data': 'Data', 'estacao_do_ano': 'Estação do Ano', 'precipitacao_mm': 'Precipitação (mm)',
        'temperatura_c': 'Temperatura (°C)', 'umidade_percentual': 'Umidade (%)',
        'densidade_populacional': 'Densidade Populacional', 'altitude_metros': 'Altitude (metros)', 'declividade_graus': 'Declividade (graus)',
        'distancia_agua_km': 'Distância da Água (km)', 'tipo_de_solo': 'Tipo de Solo', 'uso_do_solo': 'Uso do Solo',
        'nivel_acessibilidade': 'Nível de Acessibilidade', 'frequencia_sismos': 'Frequência de Sismos', 'tipo_evento': 'Tipo de Evento',
        'nivel_de_risco': 'Nível de Risco', 'ocorreu': 'Ocorreu'
    };
    const translateField = (fieldName) => fieldTranslations[fieldName] || fieldName;
    
    // --- NOVA FUNÇÃO PARA OBTER LOCALIZAÇÃO ---
    function captureUserLocation() {
        if ('geolocation' in navigator) {
            navigator.geolocation.getCurrentPosition(
                (position) => {
                    currentUserLat = position.coords.latitude;
                    currentUserLon = position.coords.longitude;
                    console.log(`Localização capturada: Lat ${currentUserLat}, Lon ${currentUserLon}`);
                },
                (error) => {
                    console.error("Erro ao obter localização: ", error.message);
                    showNotification("Não foi possível obter a sua localização.", "error");
                }
            );
        } else {
            console.log("Geolocalização não é suportada por este navegador.");
        }
    }
    // Captura a localização assim que a página carrega
    captureUserLocation();

    // --- FUNÇÕES DE CONTROLO DA UI ---
    function showLoader() { initialMessage.classList.add('d-none'); table.classList.add('d-none'); actionPanel.classList.add('d-none'); loadingSpinner.classList.remove('d-none'); }
    function hideLoader() { loadingSpinner.classList.add('d-none'); }
    function showTable() { initialMessage.classList.add('d-none'); loadingSpinner.classList.add('d-none'); table.classList.remove('d-none'); actionPanel.classList.remove('d-none');}
    function showNotification(message, type = 'success') {
        const container = document.getElementById('notification-container');
        const notification = document.createElement('div');
        notification.className = `toast-notification ${type}`;
        notification.textContent = message;
        container.appendChild(notification);
        setTimeout(() => { notification.remove(); }, 5000);
    }
    function showConfirmModal(title, body) {
        return new Promise((resolve) => {
            const modalTemplate = document.getElementById('confirm-modal-template').content.cloneNode(true);
            modalContainer.innerHTML = '';
            modalContainer.appendChild(modalTemplate);
            const confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
            document.getElementById('confirmModalTitle').textContent = title;
            document.getElementById('confirmModalBody').textContent = body;
            const okBtn = document.getElementById('confirm-ok-btn');
            const cancelBtn = document.getElementById('confirm-cancel-btn');
            const onOk = () => { confirmModal.hide(); resolve(true); };
            const onCancel = () => { confirmModal.hide(); resolve(false); };
            okBtn.addEventListener('click', onOk, { once: true });
            cancelBtn.addEventListener('click', onCancel, { once: true });
            document.getElementById('confirmModal').addEventListener('hidden.bs.modal', () => { modalContainer.innerHTML = ''; }, { once: true });
            confirmModal.show();
        });
    }

    // --- FUNÇÕES DE DADOS (CRUD E BUSCA) ---
    async function fetchAndDisplayData(collectionName) {
        showLoader();
        currentCollection = collectionName;
        currentCollectionTitle.textContent = collectionName;
        addNewBtn.disabled = false;
        exportBtn.disabled = false;
        searchInput.value = '';
        document.querySelectorAll('.collection-nav a').forEach(a => { a.classList.toggle('active', a.dataset.collection === collectionName); });
        try {
            const response = await fetch(`/api/data/${collectionName}`);
            if (!response.ok) throw new Error('Falha ao buscar dados da API.');
            currentData = await response.json();
            renderTable(currentData);
        } catch (error) {
            showNotification(error.message, 'error');
            hideLoader();
            initialMessage.classList.remove('d-none');
            initialMessage.querySelector('p').textContent = 'Erro ao carregar dados.';
        }
    }

    function renderTable(dataToRender) {
        tableHead.innerHTML = '';
        tableBody.innerHTML = '';
        if (currentData.length === 0) {
            hideLoader();
            actionPanel.classList.remove('d-none');
            initialMessage.classList.remove('d-none');
            initialMessage.querySelector('p').textContent = 'Nenhum documento para exibir. Adicione um novo documento.';
            table.classList.add('d-none');
            headers = [];
            return;
        }
        headers = Object.keys(currentData[0]).filter(h => h !== '_id');
        const headerRow = document.createElement('tr');
        headers.forEach(header => {
            const th = document.createElement('th');
            th.textContent = translateField(header);
            headerRow.appendChild(th);
        });
        headerRow.innerHTML += `<th>Ações</th>`;
        tableHead.appendChild(headerRow);
        if (dataToRender.length === 0) {
            tableBody.innerHTML = `<tr><td colspan="${headers.length + 1}" class="text-center">Nenhum resultado encontrado para a sua busca.</td></tr>`;
        } else {
             dataToRender.forEach(doc => {
                const row = document.createElement('tr');
                headers.forEach(header => {
                    const td = document.createElement('td');
                    td.textContent = doc[header];
                    row.appendChild(td);
                });
                row.innerHTML += `
                    <td>
                        <button class="btn-icon edit-btn" title="Editar" data-id="${doc._id}"><i class="bi bi-pencil-fill"></i></button>
                        <button class="btn-icon delete-btn" title="Deletar" data-id="${doc._id}"><i class="bi bi-trash-fill"></i></button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        }
        hideLoader();
        showTable();
    }
    
    // --- FUNÇÃO DO MODAL ATUALIZADA ---
    function openFormModal(doc = null) {
        const modalTemplate = document.getElementById('modal-template').content.cloneNode(true);
        modalContainer.innerHTML = '';
        modalContainer.appendChild(modalTemplate);
        const formModal = new bootstrap.Modal(document.getElementById('formModal'));
        const modalTitle = document.getElementById('formModalLabel');
        const dataForm = document.getElementById('data-form');
        const saveBtn = document.getElementById('save-btn');
        modalTitle.textContent = doc ? 'Editar Documento' : 'Adicionar Novo Documento';
        dataForm.innerHTML = '';
        const fields = (headers.length > 0) ? headers : Object.keys(fieldTranslations);
        
        fields.forEach(headerKey => {
            let value = doc ? doc[headerKey] : '';
            const inputType = headerKey === 'data' ? 'datetime-local' : 'text';

            // Se for um campo de data existente, formata para o input
            if (doc && headerKey === 'data' && value) {
                value = value.replace(' ', 'T');
            }

            const formGroup = document.createElement('div');
            formGroup.className = 'col-md-6';
            formGroup.innerHTML = `
                <label for="${headerKey}" class="form-label">${translateField(headerKey)}</label>
                <input type="${inputType}" class="form-control" id="${headerKey}" name="${headerKey}" value="${value || ''}">
            `;
            dataForm.appendChild(formGroup);
        });

        // --- LÓGICA DE PREENCHIMENTO AUTOMÁTICO ATUALIZADA ---
        if (!doc) { // Apenas para novos documentos
            // Preenche a data e hora
            const dateInput = dataForm.querySelector('#data');
            if (dateInput) {
                const now = new Date();
                const year = now.getFullYear();
                const month = (now.getMonth() + 1).toString().padStart(2, '0');
                const day = now.getDate().toString().padStart(2, '0');
                const hours = now.getHours().toString().padStart(2, '0');
                const minutes = now.getMinutes().toString().padStart(2, '0');
                dateInput.value = `${year}-${month}-${day}T${hours}:${minutes}`;
            }

            // Preenche a latitude
            const latInput = dataForm.querySelector('#latitude');
            if (latInput && currentUserLat !== null) {
                latInput.value = currentUserLat.toFixed(6);
            }

            // Preenche a longitude
            const lonInput = dataForm.querySelector('#longitude');
            if (lonInput && currentUserLon !== null) {
                lonInput.value = currentUserLon.toFixed(6);
            }
        }
        
        saveBtn.onclick = () => saveFormData(doc ? doc._id : null, formModal);
        document.getElementById('formModal').addEventListener('hidden.bs.modal', () => { modalContainer.innerHTML = ''; }, { once: true });
        formModal.show();
    }

    async function saveFormData(docId, modalInstance) {
        const form = document.getElementById('data-form');
        const formData = new FormData(form);
        const data = {};
        
        formData.forEach((value, key) => {
            // Formata a data para um formato legível antes de salvar
            if (key === 'data' && value) {
                data[key] = value.replace('T', ' ');
            } else if (value.trim() !== '' && !isNaN(value)) {
                data[key] = Number(value);
            } else {
                data[key] = value;
            }
        });

        const url = docId ? `/api/data/${currentCollection}/${docId}` : `/api/data/${currentCollection}`;
        const method = docId ? 'PUT' : 'POST';
        try {
            const response = await fetch(url, { method: method, headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) });
            const result = await response.json();
            if (!result.success) throw new Error(result.error || 'Erro desconhecido ao salvar.');
            showNotification(result.message, 'success');
            modalInstance.hide();
            await fetchAndDisplayData(currentCollection);
        } catch (error) {
            showNotification(error.message, 'error');
        }
    }
    
    async function deleteDoc(docId) {
        const confirmed = await showConfirmModal('Confirmar Exclusão', 'Deseja realmente deletar este documento?');
        if (!confirmed) return;
        try {
            const response = await fetch(`/api/data/${currentCollection}/${docId}`, { method: 'DELETE' });
            const result = await response.json();
            if (!result.success) throw new Error(result.error);
            showNotification(result.message, 'success');
            await fetchAndDisplayData(currentCollection);
        } catch (error) {
            showNotification(error.message, 'error');
        }
    }
    
    // --- EVENT LISTENERS ---
    collectionList.addEventListener('click', (e) => {
        e.preventDefault();
        if (e.target.tagName === 'A' || e.target.closest('a')) {
            const collectionName = (e.target.tagName === 'A' ? e.target : e.target.closest('a')).dataset.collection;
            fetchAndDisplayData(collectionName);
        }
    });
    addNewBtn.addEventListener('click', () => { if (currentCollection) { openFormModal(); } });
    exportBtn.addEventListener('click', () => { if(currentCollection) { window.location.href = `/api/export/${currentCollection}`; } });
    tableBody.addEventListener('click', (e) => {
        const editBtn = e.target.closest('.edit-btn');
        if (editBtn) {
            const docId = editBtn.dataset.id;
            const docToEdit = currentData.find(d => d._id === docId);
            if (docToEdit) openFormModal(docToEdit);
        }
        const deleteBtn = e.target.closest('.delete-btn');
        if (deleteBtn) {
            const docId = deleteBtn.dataset.id;
            deleteDoc(docId);
        }
    });
    searchInput.addEventListener('keyup', () => {
        const searchTerm = searchInput.value.toLowerCase();
        const filteredData = currentData.filter(doc => {
            return Object.values(doc).some(value => 
                String(value).toLowerCase().includes(searchTerm)
            );
        });
        renderTable(filteredData);
    });
});