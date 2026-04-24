import { useState } from 'react';
import { ShieldCheck, ArrowRight, Loader2 } from 'lucide-react';
import api from '../api/axios';

export default function Login() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    const [errorMsg, setErrorMsg] = useState("");

    const handleLogin = async (e) => {
        e.preventDefault();
        setIsLoading(true);
        setErrorMsg("");
        
        try {
            const res = await api.post('/Auth/login', { email, password });
            localStorage.setItem('token', res.data.token);
            window.location.href = '/admin';
        } catch (err) {
            // حل مشكلة ESLint: استخدمنا المتغير err لعرض رسالة خطأ للمستخدم
            const message = err.response?.data?.message || "Invalid Admin Credentials";
            setErrorMsg(message);
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="min-h-screen bg-brand-dark flex items-center justify-center p-6">
            <div className="glass-card w-full max-w-md p-10 rounded-[2.5rem] border border-white/5 relative">
                <div className="text-center mb-10">
                    <div className="inline-flex p-4 bg-brand-accent/10 rounded-3xl text-brand-accent mb-4">
                        <ShieldCheck size={40}/>
                    </div>
                    <h1 className="text-3xl font-black text-white italic tracking-tighter">AOUN SECURITY</h1>
                    <p className="text-slate-500 mt-2">Access Central Control System</p>
                </div>

                {errorMsg && (
                    <div className="mb-6 p-4 bg-rose-500/10 border border-rose-500/20 rounded-2xl text-rose-500 text-sm font-bold text-center animate-bounce">
                        {errorMsg}
                    </div>
                )}

                <form className="space-y-5" onSubmit={handleLogin}>
                    <div className="space-y-2">
                        <label className="text-xs font-bold text-slate-500 uppercase ml-2 tracking-widest">Email Address</label>
                        <input 
                            type="email" required
                            className="w-full bg-white/5 border border-white/10 rounded-2xl py-4 px-6 text-white focus:border-brand-accent outline-none transition-all"
                            onChange={(e) => setEmail(e.target.value)}
                        />
                    </div>
                    <div className="space-y-2">
                        <label className="text-xs font-bold text-slate-500 uppercase ml-2 tracking-widest">Secret Key</label>
                        <input 
                            type="password" required
                            className="w-full bg-white/5 border border-white/10 rounded-2xl py-4 px-6 text-white focus:border-brand-accent outline-none transition-all"
                            onChange={(e) => setPassword(e.target.value)}
                        />
                    </div>
                    <button 
                        disabled={isLoading}
                        className="w-full bg-brand-accent hover:bg-sky-400 disabled:opacity-50 text-brand-dark py-4 rounded-2xl font-black flex items-center justify-center gap-2 transition-all mt-4 shadow-xl shadow-brand-accent/20"
                    >
                        {isLoading ? <Loader2 className="animate-spin" /> : <>AUTHORIZE ACCESS <ArrowRight size={20}/></>}
                    </button>
                </form>
            </div>
        </div>
    );
}