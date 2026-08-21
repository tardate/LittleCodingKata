/* jo3dview.js - V1.04 2025 (C) JoEmbedded.de - 3D Viewer Module */
import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

export function view3d(containerId, modelFname, tscale = 1, loaderId = undefined, backimg = undefined, shift2org = true) {
    const data3d = {
        container: document.getElementById(containerId),
        scene: new THREE.Scene()
    }
    // Funktion: Erzeuge kline einfarbiges Canvas Textur
    function createCanvasTexture(colorTop, colorBottom) {
        const size = 128;
        const canvas = document.createElement('canvas');
        canvas.width = size;
        canvas.height = size;
        const context = canvas.getContext('2d');
        // Farbverlauf (oben -> unten)
        const gradient = context.createLinearGradient(0, 0, 0, size);
        gradient.addColorStop(0, colorTop);
        gradient.addColorStop(1, colorBottom);
        context.fillStyle = gradient;
        context.fillRect(0, 0, size, size);
        return new THREE.CanvasTexture(canvas);
    }

    if (backimg === undefined) {
        const bkTexture = createCanvasTexture('#ffffff', '#202030');
        bkTexture.mapping = THREE.EquirectangularReflectionMapping;
        data3d.scene.environment = bkTexture;
        data3d.scene.background = new THREE.Color(0x202028); // better
    } else {
        const bkTexture = new THREE.TextureLoader().load(backimg)
        bkTexture.mapping = THREE.EquirectangularReflectionMapping;
        data3d.scene.environment = bkTexture;
        data3d.scene.background = bkTexture;
    }

    data3d.camera = new THREE.PerspectiveCamera(30, data3d.container.clientWidth / data3d.container.clientHeight, 0.1, 1000);
    data3d.camera.position.set(0, 2, 0.5);
    data3d.renderer = new THREE.WebGLRenderer({ antialias: true });
    if (backimg !== undefined) {
        data3d.renderer.toneMapping = THREE.ACESFilmicToneMapping;
        data3d.renderer.outputEncoding=THREE.sRGBEncoding;
    }
    data3d.renderer.setPixelRatio(window.devicePixelRatio);
    //data3d.renderer.setSize(window.innerWidth, window.innerHeight); // variable size
    data3d.renderer.setSize(data3d.container.clientWidth - 1, data3d.container.clientHeight - 1);
    data3d.renderer.setAnimationLoop(animate);
    data3d.renderer.outputEncoding = THREE.sRGBEncoding;
    data3d.renderer.toneMappingExposure = 1.2;
    data3d.renderer.toneMapping = THREE.LinearToneMapping;
    data3d.container.appendChild(data3d.renderer.domElement);
    window.addEventListener('resize', () => {
        data3d.renderer.setSize(data3d.container.clientWidth - 1, data3d.container.clientHeight - 1);
        data3d.camera.aspect = data3d.container.clientWidth / data3d.container.clientHeight;
        data3d.camera.updateProjectionMatrix();
    });

    // GLTF/GLB laden
    data3d.modelscale = undefined; // set after full loaded!
    data3d.targetscale = tscale;
    const loader = new GLTFLoader();
    if (loaderId) {
        data3d.loaderDiv = document.getElementById(loaderId); // Loader per Model
        data3d.loaderDiv.textContent = 'Loading...';
    }
    loader.load(
        modelFname,
        (gltf) => {
            data3d.model = gltf.scene;

            // Mittelpunkt berechnen und verschieben
            const box = new THREE.Box3().setFromObject(data3d.model);
            const center = new THREE.Vector3();
            box.getCenter(center);
            if(shift2org)data3d.model.position.sub(center);
            // Modell skalieren, sodass es einigermassen den Viewer füllt
            const size = box.getSize(new THREE.Vector3());
            const maxDim = Math.max(size.x, size.y, size.z);
            const desiredSize = tscale; /* Default-Size fürs Test-Model, kann man noch optimieren */
            data3d.targetscale = desiredSize / maxDim;
            data3d.modelscale = Math.max(data3d.model.scale.x, data3d.model.scale.y, data3d.model.scale.z);
            data3d.model.scale.setScalar(0.01);
            data3d.scene.add(data3d.model);
            data3d.modRotTarget = new THREE.Vector3(0, 0, 0);
            data3d.model.rotation.set(3.14, 1.7, 0.8);

            // Ausgabe Box in der Konsole
            console.log('Model:', modelFname);
            console.log('BoundingBox min:', box.min);
            console.log('BoundingBox max:', box.max);
            console.log('Size:', box.getSize(new THREE.Vector3()));
            console.log('Center:', box.getCenter(new THREE.Vector3()));

            // OPTIONAL: BoxHelper in ROT zum Anzeigen im Viewport
            //const boxHelper = new THREE.BoxHelper(model, 0xff0000);
            //scene.add(boxHelper);
            if (data3d.loaderDiv) data3d.loaderDiv.style.display = 'none';
        },
        (xhr) => {
            let proc = (xhr.loaded / xhr.total * 100).toFixed(1);
            if (proc > 100) proc = 100;
            if (data3d.loaderDiv) data3d.loaderDiv.textContent = (proc < 100) ? `Loaded: ${proc}%` : `Init 3D...`;
        },
        (error) => {
            if (data3d.loaderDiv) data3d.loaderDiv.textContent = 'Load Error: ' + error;
        }
    );
    //  Controls - erst aktivieren wenn alles geladen
    data3d.controls = new OrbitControls(data3d.camera, data3d.renderer.domElement);
    data3d.controls.enableDamping = true;
    data3d.controls.autoRotate = true;
    data3d.controls.autoRotateSpeed = 0.1;
    // Animation loop
    function animate() {
        if (data3d.modelscale !== undefined) {
            data3d.modelscale += 0.25 * (data3d.targetscale - data3d.modelscale); // ease to Size
            data3d.model.scale.setScalar(data3d.modelscale);
            data3d.model.rotation.x += 0.15 * (data3d.modRotTarget.x - data3d.model.rotation.x); // and rotate
            data3d.model.rotation.y += 0.12 * (data3d.modRotTarget.y - data3d.model.rotation.y);
            data3d.model.rotation.z += 0.1 * (data3d.modRotTarget.z - data3d.model.rotation.z);
        }
        data3d.controls.update();
        data3d.renderer.render(data3d.scene, data3d.camera);
    }
    // data3d contains ALL variables to control the 3D view
    return data3d;
}
// ***
