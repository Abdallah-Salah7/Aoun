import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Dashboard from './pages/Dashboard';
import Charities from './pages/Charities';
import Login from './pages/Login';
import Cases from './pages/Cases';

const ProtectedRoute = ({ children }) => {
    const token = localStorage.getItem('token');
    
    if (!token) {
        return <Navigate to="/login" replace />;
    }
    
    return children;
};

export default function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/login" element={<Login />} />

                <Route 
                    path="/admin/*" 
                    element={
                        <ProtectedRoute>
                            <div className="flex min-h-screen bg-[#0b1120]">
                                <Sidebar />
                                <main className="flex-1 p-12 overflow-y-auto w-full">
                                    <Routes>
                                        <Route path="/" element={<Dashboard />} />
                                        <Route path="/charities" element={<Charities />} />
                                        <Route path="/cases" element={<Cases />} />
                                    </Routes>
                                </main>
                            </div>
                        </ProtectedRoute>
                    } 
                />

                <Route path="*" element={<Navigate to="/admin" replace />} />
            </Routes>
        </BrowserRouter>
    );
}