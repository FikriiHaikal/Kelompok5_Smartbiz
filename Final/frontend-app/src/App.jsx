import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
// import Login from "./components/Login"; // No longer directly used here
// import Register from "./components/Register"; // No longer directly used here
import AuthPage from "./components/AuthPage"; // Import the new AuthPage component
import Dashboard from "./components/Dashboard";  // Komponen Dashboard
import ManageUser from "./components/ManageUser";
import ManageInventaris from "./components/ManageInventaris";  // Pastikan komponen ManageInventaris diimpor
import ManageCoffeeShopFinance from "./components/ManageCoffeeShopFinance"; // Import komponen ManageCoffeeShopFinance
import ManageCoffeeShopMenu from "./components/ManageCoffeeShopMenu"; // Import the new component
import ManageKostFinance from "./components/ManageKostFinance"; // Import komponen ManageKostFinance
import ManageInventarisCoffeeShop from "./components/ManageInventarisCoffeeShop"; // Import komponen Inventaris Coffee Shop
import ManageInventarisKost from "./components/ManageInventarisKost"; // Import komponen Inventaris Kost
import ManageKos from "./components/ManageKos"; // Import ManageKos component
import PaymentForm from "./components/PaymentForm";
import Receipt from "./components/Receipt"; // Import the Receipt component
import 'bootstrap/dist/css/bootstrap.min.css';  // Pastikan Bootstrap diimpor

function App() {
  return (
    <Router>
      <div>
        <Routes>
          <Route path="/" element={<Navigate to="/login" />} />
          <Route path="/login" element={<AuthPage />} />
          <Route path="/register" element={<AuthPage />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/manage-user" element={<ManageUser />} /> {/* Route untuk Manage User */}
          <Route path="/manage-inventaris" element={<ManageInventaris />} /> {/* Route untuk Manage Inventaris */}
          <Route path="/finance/coffee-shop" element={<ManageCoffeeShopFinance />} /> {/* Route untuk Manajemen Keuangan Coffee Shop */}
          <Route path="/finance/kost" element={<ManageKostFinance />} /> {/* Route untuk Manajemen Keuangan Kost */}
          <Route path="/manage-coffee-shop-menu" element={<ManageCoffeeShopMenu />} /> {/* Route untuk Manage Coffee Shop Menu */}
          <Route path="/inventaris/coffee-shop" element={<ManageInventarisCoffeeShop />} /> {/* Route untuk Manajemen Inventaris Coffee Shop */}
          <Route path="/inventaris/kost" element={<ManageInventarisKost />} /> {/* Route untuk Manajemen Inventaris Kost */}
          <Route path="/manage-kos" element={<ManageKos />} /> {/* Route untuk Manajemen Kamar Kos */}
          <Route path="/payment-form" element={<PaymentForm />} />
          <Route path="/receipt" element={<Receipt />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
