import React, { useState, useEffect } from "react";
import axios from "axios";
// Import Button, Modal, Form, Alert from react-bootstrap, remove Card, Row, Col
import { Button, Modal, Form, Alert } from "react-bootstrap";
import {
  FaTrashAlt,
  FaEdit,
  FaPlus,
  FaArrowLeft,
  FaInfoCircle,
  FaCheckCircle,
} from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import Footer from "./Footer";
import "./ManageInventarisKost.css";
import "./SuccessModal.css";

const ManageInventarisKost = () => {
  const navigate = useNavigate();
  const [inventaris, setInventaris] = useState([]);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [showEditModal, setShowEditModal] = useState(false);
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [showSuccessModal, setShowSuccessModal] = useState(false);
  const [successMessage, setSuccessMessage] = useState("");
  const [deleteItemId, setDeleteItemId] = useState(null);
  const [validationError, setValidationError] = useState("");
  const [newItem, setNewItem] = useState({
    item_name: "",
    stock: 0,
    minimum_stock: 0,
    image: null,
    expiration_date: "",
  });
  const [editingItem, setEditingItem] = useState(null);

  const fetchInventaris = async () => {
    const token = localStorage.getItem("token");
    if (!token) {
      console.error("Authentication token not found. Cannot fetch inventaris.");
      return;
    }
    try {
      const response = await axios.get(
        "http://localhost:3001/api/inventaris?category=kost",
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      setInventaris(response.data);
    } catch (error) {
      console.error("Error fetching inventaris:", error);
    }
  };

  useEffect(() => {
    fetchInventaris();
  }, []);

  const handleBack = () => navigate("/dashboard");
  const handleDelete = async (id) => {
    const token = localStorage.getItem("token");
    if (!token) {
      console.error(
        "Token autentikasi tidak ditemukan. Tidak dapat menghapus item."
      );
      return;
    }
    try {
      await axios.delete(`http://localhost:3001/api/inventaris/${id}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      setInventaris(inventaris.filter((item) => item.id !== id));
      setShowDeleteModal(false);
      setDeleteItemId(null);

      // Show success message
      setSuccessMessage("Item inventaris berhasil dihapus!");
      setShowSuccessModal(true);

      // Auto close success modal after 2 seconds
      setTimeout(() => {
        setShowSuccessModal(false);
      }, 2000);
    } catch (error) {
      console.error("Error saat menghapus item:", error);
      // Optionally show an error modal or message here
    }
  };

  const handleDeleteClick = (id) => {
    setDeleteItemId(id);
    setShowDeleteModal(true);
  };

  const handleCreateModal = () => {
    setValidationError("");
    setShowCreateModal(true);
  };
  const handleNewItemInputChange = (e) => {
    const { name, value, files } = e.target;
    if (name === "image") {
      setNewItem({ ...newItem, [name]: files[0] });
    } else {
      setNewItem({ ...newItem, [name]: value });
    }
  };

  const handleEditingItemInputChange = (e) => {
    const { name, value, files } = e.target;
    if (name === "image") {
      setEditingItem({ ...editingItem, [name]: files[0] });
    } else {
      setEditingItem({ ...editingItem, [name]: value });
    }
  };
  const handleCreateItem = async () => {
    const token = localStorage.getItem("token");
    if (!token) {
      console.error("Authentication token not found. Cannot create item.");
      return;
    }

    // Validasi semua field required telah diisi
    if (
      !newItem.item_name ||
      !newItem.stock ||
      !newItem.minimum_stock ||
      !newItem.image ||
      !newItem.expiration_date
    ) {
      setValidationError(
        "Mohon isi semua kolom yang ditandai dengan tanda bintang (*) untuk menambahkan item."
      );
      return;
    }

    // Reset error message if validation passes
    setValidationError("");

    const formData = new FormData();
    formData.append("item_name", newItem.item_name);
    formData.append("stock", newItem.stock);
    formData.append("minimum_stock", newItem.minimum_stock);
    formData.append("category", "kost");
    if (newItem.image) {
      formData.append("image", newItem.image);
    }
    if (newItem.expiration_date) {
      formData.append("expiration_date", newItem.expiration_date);
    }

    try {
      await axios.post("http://localhost:3001/api/inventaris", formData, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data",
        },
      });

      setShowCreateModal(false);
      setSuccessMessage("Item inventaris berhasil ditambahkan!");
      setShowSuccessModal(true);

      // Reset form
      setNewItem({
        item_name: "",
        stock: 0,
        minimum_stock: 0,
        image: null,
        expiration_date: "",
      });

      // Auto close success modal after 2 seconds
      setTimeout(() => {
        setShowSuccessModal(false);
        fetchInventaris();
      }, 2000);
    } catch (error) {
      console.error("Error creating item:", error);
      // Optionally show an error modal or message here
    }
  };
  const handleEditClick = (item) => {
    setValidationError("");
    setEditingItem(item);
    setShowEditModal(true);
  };
  const handleUpdateItem = async () => {
    const token = localStorage.getItem("token");
    if (!token || !editingItem) {
      console.error(
        "Authentication token or editing item data not found. Cannot update item."
      );
      return;
    }

    // Validasi semua field required telah diisi
    if (
      !editingItem.item_name ||
      !editingItem.stock ||
      !editingItem.minimum_stock ||
      !editingItem.expiration_date
    ) {
      setValidationError(
        "Mohon isi semua kolom yang ditandai dengan tanda bintang (*) untuk memperbarui item."
      );
      return;
    }

    // Reset error message if validation passes
    setValidationError("");

    const formData = new FormData();
    formData.append("item_name", editingItem.item_name);
    formData.append("stock", editingItem.stock);
    formData.append("minimum_stock", editingItem.minimum_stock);
    formData.append("category", "kost");
    if (editingItem.image instanceof File) {
      formData.append("image", editingItem.image);
    }
    if (editingItem.expiration_date) {
      formData.append("expiration_date", editingItem.expiration_date);
    }

    try {
      await axios.put(
        `http://localhost:3001/api/inventaris/${editingItem.id}`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "multipart/form-data",
          },
        }
      );
      setShowEditModal(false);
      setSuccessMessage("Item inventaris berhasil diperbarui!");
      setShowSuccessModal(true);
      setEditingItem(null);

      // Auto close success modal after 2 seconds
      setTimeout(() => {
        setShowSuccessModal(false);
        fetchInventaris();
      }, 2000);
    } catch (error) {
      console.error("Error updating item:", error);
      // Optionally show an error modal or message here
    }
  };

  return (
    <div className="manage-inventaris-container">
      <header className="manage-inventaris-header">
        <h2 className="manage-inventaris-title">Manajemen Inventaris Kost</h2>
        <Button
          variant="primary"
          onClick={handleCreateModal}
          className="action-button"
        >
          <FaPlus /> Tambah Item
        </Button>
      </header>
      <div className="inventaris-card-list">
        {inventaris.length > 0 ? (
          inventaris.map((item) => (
            <div className="menu-card" key={item.id}>
              {" "}
              {/* Changed to div with menu-card class */}
              {item.image_url && ( // Conditionally render image
                <img
                  src={`http://localhost:3001/${item.image_url}`}
                  alt={item.item_name}
                  className="card-image" // Use card-image class
                />
              )}
              <FaInfoCircle
                className="info-icon"
                onClick={() => alert(`Info for ${item.item_name}`)}
              />{" "}
              {/* Basic info click handler */}
              <h5>{item.item_name}</h5> {/* Changed to h5 */}
              <div className="item-details">
                <p className="item-stock">
                  Stok Barang: {item.stock}
                  {item.stock <= item.minimum_stock && (
                    <span className="stock-warning-text"> (Minimum!)</span>
                  )}
                </p>
                <p className="item-min-stock">
                  Minimum Stok: {item.minimum_stock}
                </p>
                {item.expiration_date && (
                  <p
                    className={`item-expiration ${
                      new Date(item.expiration_date) < new Date()
                        ? "expired"
                        : "valid"
                    }`}
                  >
                    {new Date(item.expiration_date) < new Date()
                      ? "Expired"
                      : `Valid Until: ${new Date(
                          item.expiration_date
                        ).toLocaleDateString()}`}
                  </p>
                )}
              </div>
              <div className="menu-card-actions">
                {" "}
                {/* Added actions div */}
                <Button
                  variant="link"
                  size="sm"
                  className="edit-button"
                  onClick={() => handleEditClick(item)}
                >
                  Edit
                </Button>
                <Button
                  variant="link"
                  size="sm"
                  className="delete-button"
                  onClick={() => handleDeleteClick(item.id)}
                >
                  Delete
                </Button>
              </div>{" "}
              {/* End actions div */}
            </div> // End menu-card div
          ))
        ) : (
          <p className="text-center w-100">Tidak ada data inventaris.</p>
        )}
      </div>{" "}
      {/* End inventaris-card-list */}{" "}
      <Modal
        show={showCreateModal}
        onHide={() => {
          setShowCreateModal(false);
          setValidationError("");
        }}
      >
        <Modal.Header closeButton>
          <Modal.Title>Tambah Item Inventaris</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {validationError && (
            <Alert
              variant="danger"
              onClose={() => setValidationError("")}
              dismissible
            >
              {validationError}
            </Alert>
          )}
          <p style={{ color: "blue" }}>Kolom dengan tanda * wajib diisi</p>
          <Form>
            <Form.Group className="mb-3">
              <Form.Label>
                Nama Item <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="text"
                name="item_name"
                value={newItem.item_name}
                onChange={handleNewItemInputChange}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>
                Stok <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="number"
                name="stock"
                value={newItem.stock}
                onChange={handleNewItemInputChange}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>
                Minimum Stock <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="number"
                name="minimum_stock"
                value={newItem.minimum_stock}
                onChange={handleNewItemInputChange}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>
                Gambar Produk <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="file"
                name="image"
                accept="image/*"
                onChange={handleNewItemInputChange}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>
                Tanggal Kadaluarsa <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="date"
                name="expiration_date"
                value={newItem.expiration_date}
                onChange={handleNewItemInputChange}
                required
              />
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          {" "}
          <Button
            variant="secondary"
            onClick={() => {
              setShowCreateModal(false);
              setValidationError("");
            }}
          >
            Batal
          </Button>
          <Button variant="primary" onClick={handleCreateItem}>
            Simpan
          </Button>
        </Modal.Footer>
      </Modal>{" "}
      <Modal
        show={showEditModal}
        onHide={() => {
          setShowEditModal(false);
          setValidationError("");
        }}
      >
        <Modal.Header closeButton>
          <Modal.Title>Edit Item Inventaris</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          {validationError && (
            <Alert
              variant="danger"
              onClose={() => setValidationError("")}
              dismissible
            >
              {validationError}
            </Alert>
          )}
          <p style={{ color: "blue" }}>Kolom dengan tanda * wajib diisi</p>
          <Form>
            <Form.Group className="mb-3">
              <Form.Label>
                Nama Item <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="text"
                name="item_name"
                value={editingItem?.item_name || ""}
                onChange={handleEditingItemInputChange}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>
                Stok <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="number"
                name="stock"
                value={editingItem?.stock || ""}
                onChange={handleEditingItemInputChange}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>
                Minimum Stock <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="number"
                name="minimum_stock"
                value={editingItem?.minimum_stock || ""}
                onChange={handleEditingItemInputChange}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>Gambar Produk</Form.Label>
              <Form.Control
                type="file"
                name="image"
                accept="image/*"
                onChange={handleEditingItemInputChange}
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>
                Tanggal Kadaluarsa <span className="text-danger">*</span>
              </Form.Label>
              <Form.Control
                type="date"
                name="expiration_date"
                value={editingItem?.expiration_date || ""}
                onChange={handleEditingItemInputChange}
                required
              />
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          {" "}
          <Button
            variant="secondary"
            onClick={() => {
              setShowEditModal(false);
              setValidationError("");
            }}
          >
            Batal
          </Button>
          <Button variant="primary" onClick={handleUpdateItem}>
            Simpan Perubahan
          </Button>
        </Modal.Footer>
      </Modal>
      {/* Delete Confirmation Modal */}
      <Modal show={showDeleteModal} onHide={() => setShowDeleteModal(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Konfirmasi Hapus</Modal.Title>
        </Modal.Header>
        <Modal.Body>Apakah Anda yakin ingin menghapus item ini?</Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowDeleteModal(false)}>
            Batal
          </Button>
          <Button variant="danger" onClick={() => handleDelete(deleteItemId)}>
            Hapus
          </Button>{" "}
        </Modal.Footer>
      </Modal>
      {/* Success Modal with Checkmark Animation */}
      <Modal
        show={showSuccessModal}
        onHide={() => setShowSuccessModal(false)}
        centered
        className="success-modal"
      >
        <Modal.Body className="text-center p-4">
          <div className="success-checkmark-container">
            <FaCheckCircle className="success-checkmark-icon" />
          </div>
          <h4 className="mt-3">{successMessage}</h4>{" "}
        </Modal.Body>
      </Modal>
      {/* Footer dihapus karena sudah dihandle oleh Dashboard */}
    </div>
  );
};

export default ManageInventarisKost;
