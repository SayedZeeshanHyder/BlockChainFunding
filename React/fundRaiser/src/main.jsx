import React from 'react'
import { RouterProvider, createBrowserRouter, createRoutesFromElements,Route } from 'react-router-dom';
import ReactDOM from 'react-dom/client'
import Home from "/src/components/Home/Home.jsx";
import Dashboard from "/src/components/Dashboard/Dashboard.jsx";
import Profile from "/src/components/Profile/Profile.jsx";
import FundRaise from "/src/components/FundRaise/FundRaise.jsx";
import Blog from "/src/components/Blog/Blog.jsx";
import App from './App.jsx'
import './index.css'
import ProfileCamp from './components/Profile/ProfileCamp.jsx';
import ProfileTransaction from './components/Profile/ProfileTransaction.jsx';
import FundsPage from './components/FundsPage/FundsPage.jsx';

const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path='/'>
      <Route path='' element={<Home />} />
      <Route path='dashboard' element={<Dashboard />} />
      <Route path='profile' element={<Profile />}/>
      <Route path='myCampaigns' element={<ProfileCamp />} />
      <Route path='raisefund' element={<FundRaise />} />
      <Route path='blogs' element={<Blog />} />
      <Route path='transactions' element={<ProfileTransaction />} />
      <Route path='fund' element={<FundsPage />} />
    </Route>
  )
);
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
   <RouterProvider router = {router} />
  </React.StrictMode>,
)